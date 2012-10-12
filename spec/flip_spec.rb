require 'spec_helper'

describe Flip do
  let(:mock_redis) { mock('redis') }

  before :each do
    Flip.stub(:redis) { mock_redis }
  end

  describe 'get' do
    it 'returns nil if redis returns nil for id' do
      mock_redis.stub(:get).with('id') { nil }
      Flip.get('id').should be_nil
    end

    it "returns seconds left if it isn't time for flipping yet" do
      Time.stub(:now) { 4 }
      mock_redis.stub(:get).with('id') { '{"time_of_flip":5,"result":"heads"}'}
      Flip.get('id').should == {seconds_left: 1}
    end

    it 'returns result if time for flipping is here' do
      Time.stub(:now) { 6 }
      mock_redis.stub(:get).with('id') { '{"time_of_flip":5,"result":"heads"}'}
      Flip.get('id').should == {result: 'heads'}
    end
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
