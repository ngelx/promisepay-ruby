require 'spec_helper'

describe Promisepay::Item do
  let(:client) { Promisepay::Client.new }
  let(:item) { VCR.use_cassette('items_multiple') { client.items.find_all.first } }

  describe 'update' do
    context 'with valid attributes', vcr: { cassette_name: 'items_updated' } do
      let(:valid_attributes) { { name: 'updatedName' } }
      it 'correctly updates the item' do
        original_name = item.name
        item.update(valid_attributes)
        expect(item.name).to_not eql(original_name)
        expect(item.name).to eql('updatedName')
      end
    end

    context 'with invalid attributes', vcr: { cassette_name: 'items_updated_error' } do
      let(:invalid_attributes) { { amount: 1 } }

      it 'raises an error' do
        expect { item.update(invalid_attributes) }.to raise_error(Promisepay::UnprocessableEntity)
      end
    end
  end

  describe 'status', vcr: { cassette_name: 'items_status' } do
    it 'returns the item status' do
      status = item.status
      expect(status).to be_a(Hash)
      expect(status).to have_key('status')
      expect(status).to have_key('state')
    end
  end

  describe 'buyer', vcr: { cassette_name: 'items_buyer' } do
    it 'returns a user' do
      buyer = item.buyer
      expect(buyer).to be_a(Promisepay::User)
    end
  end

  describe 'seller', vcr: { cassette_name: 'items_seller' } do
    it 'returns a user' do
      seller = item.seller
      expect(seller).to be_a(Promisepay::User)
    end
  end

  describe 'fees' do
    context 'when no fees are available', vcr: { cassette_name: 'items_fees_empty' } do
      it 'gives back en empty array' do
        fees = item.fees
        expect(fees).to be_empty
      end
    end

    # context 'when fees are available', vcr: { cassette_name: 'items_fees' } do
    #   it 'gives back an array of fees' do
    #     fees = item.fees
    #     expect(fees).to_not be_empty
    #     expect(fees.first).to be_a(Promisepay::Fee)
    #   end
    # end
  end

  describe 'transactions' do
    context 'when no transactions are available', vcr: { cassette_name: 'items_transactions_empty' } do
      it 'gives back en empty array' do
        transactions = item.transactions
        expect(transactions).to be_empty
      end
    end

    # context 'when transactions are available', vcr: { cassette_name: 'items_transactions' } do
    #   it 'gives back an array of transactions' do
    #     transactions = item.transactions
    #     expect(transactions).to_not be_empty
    #     expect(transactions.first).to be_a(Promisepay::Transaction)
    #   end
    # end
  end

  describe 'wire_details', vcr: { cassette_name: 'items_wire_details' } do
    it 'returns a Hash' do
      details = item.wire_details
      expect(details).to be_a(Hash)
      expect(details).to have_key('reference')
    end
  end

  describe 'bpay_details', vcr: { cassette_name: 'items_bpay_details' } do
    it 'returns a Hash' do
      details = item.bpay_details
      expect(details).to be_a(Hash)
      expect(details).to have_key('reference')
    end
  end

  describe 'make_payment', vcr: { cassette_name: 'items_make_payment' } do
    it 'has to be tested'
  end

  describe 'request_payment', vcr: { cassette_name: 'items_request_payment' } do
    it 'has to be tested'
  end

  describe 'release_payment', vcr: { cassette_name: 'items_release_payment' } do
    it 'has to be tested'
  end

  describe 'request_release', vcr: { cassette_name: 'items_request_release' } do
    it 'has to be tested'
  end
end
