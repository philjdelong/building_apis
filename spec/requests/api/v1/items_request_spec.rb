require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
  end

  it "sends a single item" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["id"]).to eq(id)
  end

  it "creates a new item" do
    item_params = {
      name: "Saw",
      description: "I want to play a game."
    }

    post "/api/v1/items/", params: {item: item_params}

    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
  end

  it "updates an item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "Hammer" }

    put "/api/v1/items/#{id}", params: { item: item_params }

    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Hammer")
  end
end
