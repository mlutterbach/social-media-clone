require 'rails_helper'
begin
  require 'users_controller'
rescue LoadError
end

if defined?(UsersController)
  RSpec.describe UsersController, type: :controller do
    let(:valid_attributes) do
      {
        name: "Marcos Lutterbach",
        description: "Lorem Ipsum",
        email: "user1@email.com",
        username: "Anything"
      }
    end

    let(:invalid_attributes) do
      {
        name: "",
        description: "Lorem",
        email: "",
        username: ""
      }
    end

    describe "GET index" do
      it "assigns all users as @users" do
        user = User.create! valid_attributes
        get :index, params: {}
        expect(assigns(:users)).to eq([user])
      end
      it 'renders the index template' do
        get :index
        expect(response).to render_template("index")
      end
    end

    describe "GET new" do
      it "assigns a new user as @user" do
        get :new, params: {}
        expect(assigns(:user)).to be_a_new(User)
      end
    end

  end

else
  describe "UsersController" do
    it 'should exist' do
      expect(defined?(UsersController)).to eq(true)
    end
  end
end
