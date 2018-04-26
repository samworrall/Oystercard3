require 'oystercard.rb'

describe Oystercard do
  let(:station) { double "Station", name: :name, zone: 1}
  let(:station_2) { double "Station_2", name: :name, zone: 1}
  # let(:journey) { double "journey", start_journey: nil, end_journey: nil,
  #    entry_station: station, exit_station: station, fare: 6 }
  # subject { Oystercard.new(journey) }

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
      expect(subject.journey_log).to eq [{:entry_station => :name, :exit_station => :name}]
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
      expect(subject.journey_log).to eq [:entry_station => :name, :exit_station => :name]
    end

    it 'creates a log entry on touch in twice' do
      2.times { subject.touch_in(station) }
      expect(subject.journey_log.length).to eq(1)
    end

    it 'checks that touching in and out once creates (only) one journey' do
      subject.touch_in(station)
      subject.touch_out(station_2)
      expect(subject.journey_log[1]).to be_nil
    end
  end
end
