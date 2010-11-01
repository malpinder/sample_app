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

    describe "failure" do
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

end

