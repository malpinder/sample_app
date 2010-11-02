require 'spec_helper'

describe "Users" do

  describe "signup" do

    describe "failure" do
      before :each do
        visit signup_path
      end

      it "should fail" do
        click_button "Sign up"
        response.should render_template(:new)
        response.should have_selector('div', :id => 'error_explanation')
      end

      it "should not create a new user" do
        lambda do
          fill_in "Name",       :with => ''
          fill_in "user_email", :with => ''
          fill_in "Password",   :with => ''
          fill_in "confirm",    :with => ''
          click_button "Sign up"
          response.should render_template(:new)
          response.should have_selector('div', :id => 'error_explanation')
        end.should_not change(User, :count)
      end
    end

    describe "success" do
      before :each do
        visit signup_path
      end

      it "should create a new user" do
        lambda do
          fill_in "user_name",  :with => 'Andy Finga'
          fill_in "Email",      :with => 'andy@finga.com'
          fill_in "Password",   :with => 'foobar23'
          fill_in "confirm",    :with => 'foobar23'
          click_button "Sign up"
          response.should render_template(:show)
          response.should have_selector('div', :class => 'flash success', :content => "Welcome")
        end.should change(User, :count).by(1)
      end
    end
  end

  describe "sign in/out" do
    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in :email,    :with => ""
        fill_in :password, :with => ""
        click_button
        response.should have_selector("div.flash.error", :content => "Invalid")
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        visit signin_path
        fill_in :email,    :with => user.email
        fill_in :password, :with => user.password
        click_button
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end

end

