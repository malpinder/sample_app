require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "RoR Tut App | "
  end

  pages = %w(home help about contact)

  pages.each do |page|
    describe "GET " + page do
      it "should be successful" do
        get page
        response.should be_success
      end
      it "should have the right title" do
        get page
        response.should have_selector("title", :content => @base_title + page.capitalize)
      end
    end
  end

end

