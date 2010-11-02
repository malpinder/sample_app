require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    before :each do
      get :new
    end

    it "should be successful" do
      response.should be_success
    end

    it "should have the right 'title'" do
      response.should have_selector('title', :content => 'Sign up')
    end

    it "should have a name field" do
      response.should have_selector("input", :name => "user[name]", :type => "text")
    end

    it "should have an email field" do
      response.should have_selector("input", :name => "user[email]", :type => "text")
    end

    it "should have a password field" do
      response.should have_selector("input", :name => "user[password]", :type => "password")
    end

    it "should have a password confirmation field" do
      response.should have_selector("input", :name => "user[password_confirmation]", :type => "password")
    end
  end

  describe "GET 'show'" do
    before :each do
      @user = Factory(:user)
    end

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the correct user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it "should have the correct title" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.name)
    end

    it "should have the name in the heading" do
      get :show, :id => @user
      response.should have_selector('h2', :content => @user.name)
    end

    it "should have a profile image in the heading" do
      get :show, :id => @user
      response.should have_selector("h2>img", :class => "gravatar")
    end
  end

  describe "POST 'create'" do
    describe "failure" do
      before :each do
        @attr = { :name => '',
                  :email => '',
                  :password => '',
                  :password_confirmation => ''
        }
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Sign up")
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template(:new)
      end
    end

    # SUCCESS
    describe "success" do
      before :each do
        @attr = { :name => 'Hans Meier',
                  :email => 'example@railstutorial.org',
                  :password => 'foobar23',
                  :password_confirmation => 'foobar23'
        }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should fill a flash with a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome/i
      end

      it "should render the show user page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
        #response.should render_template(:show)
      end

      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end
    end
  end

end

