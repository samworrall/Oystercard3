require 'oystercard.rb'

describe Oystercard do
  let(:station) { double "Station", name: :name, zone: 1}
  let(:station_2) { double "Station_2", name: :name2, zone: 2}
  #No longer need a journey double as I know everything in journey works.

  it 'Has an initial balance of 0 check' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up', :top_up do
    it 'Can be topped up with specified amount' do
      value = 45
      subject.top_up(value)
      expect(subject.balance).to eq value
    end

    it 'Raises error if topping up would cause balance to exceed £90' do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      expect { subject.top_up(1) }.to raise_error("Maximum balance is £#{Oystercard::MAXIMUM_BALANCE}")
    end
  end

  describe '#touch_in', :touch_in do
    it 'Raises an error when balance is less than the minimum fare' do
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

    it 'Adds the journey to the journey log' do
      subject.touch_in(station)
      subject.touch_out(station_2)
      expect(subject.journey_log).to eq [{:entry_station => :name, :exit_station => :name2}]
    end
  end

  describe '#journey log', :log do
    before { subject.top_up(Oystercard::MAXIMUM_BALANCE) }

    it 'Checks that log is empty be default' do
      expect(subject.journey_log).to be_empty
    end

    it 'Stores a list of completed journeys' do
      subject.touch_in(station)
      subject.touch_out(station_2)
      expect(subject.journey_log).to eq [:entry_station => :name, :exit_station => :name2]
    end

    it 'Creates a log entry on touch in twice' do
      2.times { subject.touch_in(station) }
      expect(subject.journey_log.length).to eq(1)
    end

    it 'Checks that touching in and out once creates (only) one journey' do
      subject.touch_in(station)
      subject.touch_out(station_2)
      expect(subject.journey_log.length).to eq(1)
    end

    it 'Stores multiple journeys' do
      5.times {
        subject.touch_in(station)
        subject.touch_out(station_2)
      }
      expect(subject.journey_log.length).to eq(5)
    end
  end
end
