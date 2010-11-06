require 'spec_helper'

describe SessionsController do

  render_views

  describe "GET 'new'" do
    before :each do
      get :new
    end

    it "should be successful" do
      response.should be_success
    end

    it "should have the correct title" do
      response.should have_selector('title', :content => 'Sign in')
    end

    it "should have an email field" do
      response.should have_selector("input", :name => "session[email]", :type => "text")
    end

    it "should have a password field" do
      response.should have_selector("input", :name => "session[password]", :type => "password")
    end

    it "should have a sign-in button" do
      response.should have_selector("input", :id => "session_submit")
    end
  end

  describe "POST 'create'" do
    describe "failure" do
      before :each do
        @attr = { :email => "email@example.com",
                  :password => "invalid"
                }
      end

      it "should re-render the sign-in page" do
        post :create, :session => @attr
        response.should render_template(:new)
      end

      it "should have the right title" do
        post :create, :session => @attr
        response.should have_selector("title", :content => "Sign in")
      end

      it "should have a flash.now message" do
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid/i
      end
    end

    describe "success" do
      before :each do
        @user = Factory(:user)
        @attr = { :email => @user.email,
                  :password => @user.password
                }
      end

      it "should succeed and redirect to user show page" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end

      it "should sign the user in" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end
    end
  end

  describe "DELETE 'destroy'" do
    it "should sign a user out" do
      @user = Factory(:user)
      #raise @user.inspect
      test_sign_in(@user)
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
  end

end

