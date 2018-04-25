require 'journey.rb'

describe Journey do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  subject { Journey.new(entry_station, exit_station) }

  describe '#on_journey?' do
    it 'Returns nil by default' do
      expect(subject.on_journey?).to eq(nil)
    end
  end

  describe '#start_journey' do
    it 'Sets status to true when journey starts' do
      subject.start_journey
      expect(subject.on_journey?).to eq(true)
    end
  end

  describe '#end_journey' do
    it 'Sets status to false when journey ends' do
      subject.start_journey
      subject.end_journey
      expect(subject.on_journey?).to eq(false)
    end

    it 'Charges minimum fare for journey' do
      expect(subject.fare).to eq(1)
    end

    context 'Entry station is equal to nil' do
      subject { Journey.new( nil, exit_station) }
      it 'Charges penalty fare for journey without start' do
        expect(subject.fare).to eq(Journey::PENALTY_FARE)
      end
    end

    context 'Exit station is equal to nil' do
      subject { Journey.new( entry_station, nil) }
        it 'Charges penalty fare for journey without end' do
        expect(subject.fare).to eq (Journey::PENALTY_FARE)
        end
      end
    end
end
