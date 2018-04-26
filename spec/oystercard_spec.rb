require 'oystercard.rb'

describe Oystercard do
  let(:station) { double "Station" }
  let(:station_2) { double "Station_2" }
  let(:journey) { double "journey", start_journey: nil, end_journey: nil,
     entry_station: station, exit_station: station, fare: 6 }
  subject { Oystercard.new(journey) }

  it 'Has an initial balance of 0 check' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'Can be topped up with specified amount' do
      value = 20
      subject.top_up(value)
      expect(subject.balance).to eq value
    end

    it 'Raises error if user tries to top up balance to over £90' do
      subject.top_up(90)
      expect { subject.top_up(1) }.to raise_error("Max balance is #{Oystercard::MAXIMUM_BALANCE}")
    end
  end

  describe '#touch_in', :ti do
    it 'Raises an error when balance is less than £1' do
      expect { subject.touch_in(station) }.to raise_error("Insufficient funds")
    end

    xit 'Stores the value of the station where you touch in' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
      expect(subject.station).to eq station
    end

    it 'Deducts penalty fare if touching in twice' do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      subject.touch_in(station)
      expect { subject.touch_in(station) }.to change { subject.balance }.by -6
    end
  end

  describe '#touch_out', :touch_out do
    before { subject.top_up(Oystercard::MINIMUM_FARE) }
    it 'Deducts minimum fare from balance upon touching out' do
      subject.touch_in(station)
      expect { subject.touch_out(station_2) }.to change { subject.balance }.by -Oystercard::MINIMUM_FARE
    end

    it 'Adds journey to the journey log' do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journey_log).to eq [{:entry_station => station, :exit_station => station}]
    end

  end

  describe '#journey log' do
    before { subject.top_up(Oystercard::MINIMUM_FARE) }

    it 'Checks that log is empty be default' do
      expect(subject.journey_log).to be_empty
    end

    it 'Stores a list of completed journeys' do
      subject.touch_in(station)
      subject.touch_out(station_2)
      expect(subject.journey_log[0][station]).to eq station_2
    end

    it 'checks that touching in and out once creates (only) one journey' do
      subject.touch_in(station)
      subject.touch_out(station_2)
      expect(subject.journey_log[1]).to be_nil
    end
  end

  describe '#current_journey' do
    it 'Returns current journey' do
      expect(subject.journey).to eq journey
    end
  end
end
