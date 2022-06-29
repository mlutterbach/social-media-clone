require 'rails_helper'
begin
  require 'tweets_controller'
rescue LoadError
end

if defined?(TweetsController)
  RSpec.describe TweetsController, type: :controller do
  end


else
  describe "TweetsController" do
    it 'should exist' do
      expect(defined?(TweetsController)).to eq(true)
    end
  end
end
