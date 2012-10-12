require 'spec_helper'

describe Flip do
  let(:mock_redis) { mock('redis') }

  before :each do
    Flip.stub(:redis) { mock_redis }
  end

  describe 'get' do
  end

  describe 'exist?' do
    before :each do
      mock_redis.stub(:exists).with('some_id') { 'it exists' }
    end

    it 'checks if id exists in redis' do
      Flip.exist?('some_id').should == 'it exists'
    end
  end

  describe 'create' do
  end

end
