require 'spec_helper'

describe Marvelor::API::Client do
  context 'when required attributes are not available' do
    let(:params) {
      { public_key: nil, private_key: nil }
    }
    subject { Marvelor::API::Client.new(params) }

    it 'should raise an InvalidClient exception' do
      expect{subject}.to raise_error(InvalidClient)
    end
  end

  context "Characters Endpoints" do
    let(:public_key) { 'pub' }
    let(:private_key) { 'pri' }
    let(:client) { Marvelor::API::Client.new(public_key: public_key, private_key: private_key) }

    describe '#characters' do
      subject { client.characters }

      context 'when wrong api key is passed' do
        let(:public_key) { '234234' }

        it 'should return an error for InvalidCredentials' do
          response = subject
          expect(response.code).to eq(401)
          expect(response['code']).to eq('InvalidCredentials')
        end
      end

      context 'when api key is correct' do
        it 'should return list of characters' do
          response = subject
          expect(response.code).to eq(200)
        end
      end

      context 'when pagination params are not passed' do
        it 'should return list with default count' do
          response = subject
          expect(response['data']['count']).to eq(Marvelor::API::CharacterInfo::PER_PAGE)
        end
      end

      context 'when limit are passed' do
        subject { client.characters({ limit: limit }) }

        context 'when limit is passed' do
          let(:limit) { 5 }

          it 'should return list with given count' do
            response = subject
            expect(response['data']['count']).to eq(limit)
          end
        end

        context 'when limit is exceeded' do
          let(:limit) { 500 }

          it 'should return limit exceeded error' do
            expect(subject['code']).to eq(409)
            expect(subject['status']).to eq('You may not request more than 100 items.')
          end
        end
      end

      context 'when name of the character is passed' do
        let(:name) { 'hulk' }
        subject { client.characters({ name: name }) }

        it 'should return list with matching name' do
          response = subject
          expect(response['data']['results'].first['name'].downcase).to eq('hulk')
        end
      end

      context 'when ID of the character is passed' do
        subject { client.characters({ id: id }) }

        context 'when ID is invalid' do
          let(:id) { 12 }

          it 'should respond back with error' do
            response = subject
            expect(response.code).to eq(404)
            expect(response['status']).to eq("We couldn't find that character")
          end
        end

        context 'when ID is valid' do
          let(:id) { 1009144 }

          it 'should respond back with correct record' do
            response = subject
            expect(response['data']['results'].first['id']).to eq(id)
          end
        end
      end
    end
  end
end
