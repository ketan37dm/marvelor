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
    let(:client) { my_client }

    describe '#characters' do
      before do
        stub_get('characters?apikey=123456&ts=1&hash=d4f1bab013916a533ef31e3ad5fb0887', 'characters/characters.json')
      end

      it 'returns a Marvelite::API::Response object' do
        expect(client.characters).to be_a(Marvelite::API::Response)
      end

      it 'Response object is populated with JSON from the /characters endpoint' do
        expect(client.characters["status"]).to eq("Ok")
        expect(client.characters[:data][:results].size).to eq(20)
      end
    end

    describe '#character' do
      before do
        stub_get('characters?name=Spider-Man&apikey=123456&ts=1&hash=d4f1bab013916a533ef31e3ad5fb0887', 'characters/character.json')
        stub_get('characters/1009610?apikey=123456&ts=1&hash=d4f1bab013916a533ef31e3ad5fb0887', 'characters/character.json')
        stub_get('characters/1009227?apikey=123456&ts=1&hash=d4f1bab013916a533ef31e3ad5fb0887', 'characters/character_2.json')
      end
      it 'returns a Marvelite::API::Response object' do
        expect(client.character(1009610)).to be_a(Marvelite::API::Response)
      end

      it 'Response object is populated with JSON from the /characters/:id endpoint' do
        expect(client.character(1009610)[:data][:results][0][:name]).to eq('Spider-Man')
      end

      it 'accepts an Integer as character id' do
        expect(client.character(1009610)[:data][:results][0][:name]).to eq('Spider-Man')
        expect(client.character(1009227)[:data][:results][0][:name]).to eq('Carnage')
      end

      it 'accepts a String as character name' do
        expect(client.character('Spider-Man')[:data][:results][0][:name]).to eq('Spider-Man')
      end
    end
  end
end

private

def my_client
  Marvelor::API::Client.new(
    public_key: '35ba892b1c7e6b0a210c06357b898989',
    private_key: '203ad89b51deac9e302502339c744702b2d9513b'
  )
end
