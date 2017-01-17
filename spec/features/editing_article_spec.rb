require 'rails_helper'

RSpec.feature " Editting an article" do 
	before do 
		@article= Article.create(title: "Title", body: "body") 
	end
	scenario " A user updates an article" do 
		visit "/"
		click_link @article.title

		click_link "Edit Article"

		fill_in "Title", with: "updated Title"
		fill_in "Body", with: "updated body of Article"
		click_button "Update Article"

		expect(page).to have_content("Article has been updated")
		expect(page.current_path).to eq(article_path(@article))
	end
scenario " A user fails to updates an article" do 
		visit "/"
		click_link @article.title

		click_link "Edit Article"

		fill_in "Title", with: ""
		fill_in "Body", with: "updated body of Article"
		click_button "Update Article"

		expect(page).to have_content("Article has not been updated")
		expect(page.current_path).to eq(article_path(@article))
	end
end
