require 'spec_helper'

describe Micropost do
  before :each do
    @user = Factory(:user)
    @attr = { :content => "Text of Micropost" }
  end

  it "should create a new micropost given valid attributes" do
    @user.microposts.create!(@attr)
  end

  describe "user associations" do
    before :each do
      @micropost = @user.microposts.create(@attr)
    end

    it "should have a user attribute" do
      @micropost.should respond_to(:user)
    end

    it "should have the right associated user" do
      @micropost.user_id.should == @user.id
      @micropost.user.should == @user
    end
  end

  describe "validations" do
    it "should require a user_id" do
      Micropost.new(@attr).should_not be_valid
    end

    it "should require non-blank content" do
      @user.microposts.build(:content => '  ').should_not be_valid
    end

    it "should reject too long content" do
      @user.microposts.build(:content => "a"*141).should_not be_valid
    end
  end
end

