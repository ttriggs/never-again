describe Review do
  it { should belong_to(:user) }
  it { should belong_to(:restaurant) }
  it { should have_many(:likes).dependent(:destroy) }

  it { should_not have_valid(:rating).when("string", 1.5, 11, nil) }
  it { should have_valid(:rating).when(1, 2, 3, 4, 5) }

  it { should have_valid(:body).when("An affront to all five senses", nil) }
  it { should_not have_valid(:body).when("hi", 3) }
end
