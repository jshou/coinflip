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
    before :each do
      SecureRandom.stub(:hex).with(2) { 'truly random' }
      Time.stub(:now) { 0 }
      Flip.stub(:rand) { 1 }
    end
    it 'sets id => flip_data in redis' do
      mock_redis.should_receive(:set).with('truly random', '{"time_of_flip":4,"result":"tails"}')
      Flip.create(4)
    end
  end

end
