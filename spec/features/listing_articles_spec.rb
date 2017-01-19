require "rails_helper"

RSpec.feature "Listing Articles" do

	before do
		@john=User.create(email: "john@example.com",password: "password")
		@article1=Article.create(title: "title1", body: "body of first article", user: @john)
		@article2=Article.create(title: "title2", body: "body of secon article", user: @john)
		login_as(@john)

	end

	scenario "With articles created and user signed in" do

		visit "/"

		expect(page).to have_content(@article1.title)
		expect(page).to have_content(@article1.body)
		expect(page).to have_content("Created by #{@article1.user.email}")
		expect(page).to have_content(@article2.title)
		expect(page).to have_content(@article2.body)
		expect(page).to have_content("Created by #{@article2.user.email}")
		expect(page).to have_link(@article1.title)
		expect(page).to have_link(@article2.title)
		expect(page).to have_link("New Article")
	end

	scenario "with articles created and user not signed in" do

		visit "/"

		expect(page).to have_content(@article1.title)
		expect(page).to have_content(@article1.body)
		expect(page).to have_content("Created by #{@article1.user.email}")
		expect(page).to have_content(@article2.title)
		expect(page).to have_content(@article2.body)
		expect(page).to have_content("Created by #{@article2.user.email}")
		expect(page).to have_link(@article1.title)
		expect(page).to have_link(@article2.title)
		expect(page).to have_link("New Article")
	end

	scenario "A user has no articles" do

		Article.delete_all

		visit "/"

		expect(page).not_to have_content(@article1.title)
		expect(page).not_to have_content(@article2.title)
		expect(page).not_to have_content(@article1.body)
		expect(page).not_to have_content(@article2.body)
		expect(page).not_to have_link(@article1.title)
		expect(page).not_to have_link(@article2.title)
		within("h1#no-articles") do
			expect(page).to have_content("no articles created")
		end
	end

end
