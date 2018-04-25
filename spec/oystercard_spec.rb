require 'oystercard.rb'

describe Oystercard do
  let(:station) { double "Station" }
  let(:station_2) { double "Station_2"}

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


    it "sets in_journey to true when touching in" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it "set in_journey to false when touching out" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
      subject.touch_out(station_2)
      expect(subject).not_to be_in_journey
    end
  end

  context '#touch_in' do
    it "raises an error when balance is less than £1" do
      expect { subject.touch_in(station) }.to raise_error("Insufficient funds")
    end

    it "stores the value of the station where you touch in" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
      expect(subject.station).to eq station
    end
  end

  context '#touch_out' do
    before { subject.top_up(Oystercard::MINIMUM_FARE) }
    it "deducts minimum fare from balance upon touching out" do
      subject.touch_in(station)
      expect { subject.touch_out(station_2) }.to change{ subject.balance }.by -1
    end

    it "Sets station attribute to nil" do
      subject.touch_in(station)
      subject.touch_out(station_2)
      expect(subject.station).to eq nil
    end

    it "Records touch out station" do
      subject.touch_in(station)
      subject.touch_out(station_2)
      expect(subject.station_2).to eq station_2
    end
  end

  context '#journey log' do
    before { subject.top_up(Oystercard::MINIMUM_FARE) }

    it "Checks that log is empty be default" do
      expect(subject.journey_log).to be_empty
    end

    it "stores a list of completed journeys" do
      subject.touch_in(station)
      subject.touch_out(station_2)
      expect(subject.journey_log[0][station]).to eq station_2
    end

    it "checks that touching in and out once creates (only) one journey" do
      subject.touch_in(station)
      subject.touch_out(station_2)
      expect(subject.journey_log[1]).to be_nil
    end
  end

end
