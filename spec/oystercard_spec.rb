require 'oystercard.rb'

describe Oystercard do
  it "has an initial balance of 0 check" do
    expect(subject.balance).to eq 0
  end

  context '#top_up' do
    it "can be topped up with specified amount" do
      value = 20
      subject.top_up(value)
      expect(subject.balance).to eq value
    end
  end

end
