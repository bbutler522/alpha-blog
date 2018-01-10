require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "jon", email: "jon@main.com", password: "password", admin: true)
  end
  
  test "get new category form and create category" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    
    # Create category and have it display somewhere
    assert_difference 'Category.count', 1 do # There should be a difference once we create a new category
      post_via_redirect categories_path, category: {name: "sports"} # Submission of new form handled by create action (http post request) and pass in a new category
    end
    
    assert_template 'categories/index' # Send user to categories listing page
    assert_match "sports", response.body # Ensure category name is displayed and was created
  end
  
  test "invalid category submission results in failure" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    
    assert_no_difference 'Category.count' do # this time, ensure no difference
      post categories_path, category: {name: "sp"}
    end
    
    assert_template 'categories/new' # ensure we redirect to the new template
    assert_select 'h2.panel-title' # ensure our error message appears
    assert_select 'div.panel-body'
  end
  
end