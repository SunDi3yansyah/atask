require 'rails_helper'

RSpec.describe LatestStockPrice, type: :lib do
  let(:latest_stock_price_response) { '{}' }
  let(:latest_stock_price_http) { :get }
  let(:latest_stock_price_status) { 200 }

  before do
    stub_request(latest_stock_price_http, /latest-stock-price.p.rapidapi.com/).
      with(headers: { 'User-Agent': 'Ruby', 'Content-Type': 'application/json', 'Accept': 'application/json' }).
      to_return(
        status: latest_stock_price_status,
        headers: { 'Content-Type': 'application/json' },
        body: latest_stock_price_response
      )
  end

  describe 'Library for LatestStockPrice' do

    context 'Without method/endpoint' do
      it { expect(LatestStockPrice.class.name).to eq('Class') }
      it { expect(LatestStockPrice.new.class.name).to eq('LatestStockPrice') }
    end

    context 'Price' do
      let(:latest_stock_price_payload) {
        {
          path: 'price'
        }
      }
      let(:latest_stock_price) {
        LatestStockPrice.new.price(latest_stock_price_payload)
      }
      let(:parsed_response) {
        latest_stock_price.parsed_response
      }

      context 'Success' do
        let(:latest_stock_price_response) { File.read("#{fixture_path}/responses/latest_stock_price/price/success.json") }

        it { expect(parsed_response.class).to eq(Array) }
        it { expect(latest_stock_price.code).to eq(200) }
        it { expect(parsed_response.first.keys.include?('symbol')).to be_truthy }
        it { expect(parsed_response.first.keys.include?('identifier')).to be_truthy }
        it { expect(parsed_response.size).to be > 1 }
      end

      context 'Empty' do
        let(:latest_stock_price_response) { File.read("#{fixture_path}/responses/latest_stock_price/price/empty.json") }

        it { expect(parsed_response.class).to eq(Array) }
        it { expect(latest_stock_price.code).to eq(200) }
      end

      context 'Error' do
        let(:latest_stock_price_status) { 403 }
        let(:latest_stock_price_response) { File.read("#{fixture_path}/responses/latest_stock_price/price/error.json") }

        it { expect(parsed_response.class).to eq(Hash) }
        it { expect(latest_stock_price.code).to eq(403) }
      end
    end

  end

end
