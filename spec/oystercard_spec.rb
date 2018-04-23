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

    it "raises error if user tries to top up balance to over £90" do
      subject.top_up(90)
      expect { subject.top_up(1) }.to raise_error("Max balance is #{Oystercard::MAXIMUM_BALANCE}")
    end
  end

  context "#in_journey" do
    it "returns value of in_use attribute" do
      expect(subject).not_to be_in_journey
    end


    xit "sets in_journey to true when touching in" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    xit "set in_journey to false when touching out" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

  context '#touch_in' do
    xit "raises an error when balance is less than £1" do
      expect { subject.touch_in }.to raise_error("Insufficient funds")
    end

    it "stores the value of the station where you touch in" do
      station_name = "Waterloo"
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station_name)
      expect(subject.station).to eq station_name
    end



  end

  context '#touch_out' do
    xit "deducts minimum fare from balance upon touching out" do
      subject.top_up(5)
      subject.touch_in
      expect { subject.touch_out }.to change{ subject.balance }.by -1
    end
  end
























end
