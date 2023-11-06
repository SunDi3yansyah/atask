require 'rails_helper'

RSpec.describe JsonWebToken, type: :lib do

  let!(:encode) { JsonWebToken.encode({ id: 1 }) }
  let!(:decode) { JsonWebToken.decode(encode) }

  describe 'Library for Authentication' do
    context 'Method: encode' do
      it { expect(encode).not_to be_nil }
      it { expect(encode.class).to eq(String) }
      it { expect(encode.split('.').size).to eq(3) }
      it { expect(encode.split('.').class).to eq(Array) }
    end

    context 'Method: decode' do
      it { expect(decode.class).to eq(Array) }
      it { expect(decode.first['id']).to eq(1) }
      it { expect(decode.first['exp'].class).to eq(Integer) }
      it { expect(decode.first['iss']).to eq(JWT_META_ISS) }
      it { expect(decode.first['aud']).to eq(JWT_META_AUD) }
      it { expect(decode.last['alg']).to eq('HS256') }
    end

    context 'Method: valid_payload' do
      it { expect(JsonWebToken.valid_payload(decode.first)).to eq(true) }
    end

    context 'Method: meta' do
      it { expect(JsonWebToken.meta.class).to eq(Hash) }
      it { expect(JsonWebToken.meta[:exp].class).to eq(Integer) }
      it { expect(JsonWebToken.meta[:iss]).to eq(JWT_META_ISS) }
      it { expect(JsonWebToken.meta[:aud]).to eq(JWT_META_AUD) }
    end

    context 'Method: expired' do
      it { expect(JsonWebToken.expired(decode.first)).to eq(false) }
    end
  end

end
