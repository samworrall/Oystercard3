require 'oystercard.rb'

describe Oystercard do
  it "has an initial balance of 0 check" do
    expect(subject.balance).to eq 0
  end
end
