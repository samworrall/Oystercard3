require 'journey.rb'

describe Journey do
  let(:station) { double :station, name: :name, zone: :zone }

  describe '#on_journey?' do
    it 'Returns nil by default' do
      expect(subject.on_journey?).to eq(nil)
    end
  end

  describe '#start_journey' do
    it 'Sets status to true when journey starts' do
      subject.start_journey(station)
      expect(subject.on_journey?).to eq(true)
    end

    it 'Adds entry station name' do
      subject.start_journey(station)
      expect(subject.entry_station).to eq :name
    end
  end

  describe '#end_journey' do
    it 'Sets status to false when journey ends' do
      subject.start_journey(station)
      subject.end_journey(station)
      expect(subject.on_journey?).to eq(false)
    end

    it 'Charges minimum fare for journey' do
      subject.start_journey(station)
      subject.end_journey(station)
      expect(subject.fare).to eq(Journey::MINIMUM_FARE)
    end

    it 'Adds exit_station name' do
      expect(subject.end_journey(station)).to eq :name
    end

    context 'Entry station is equal to nil' do
      it 'Charges penalty fare for journey without start' do
        subject.end_journey(station)
        expect(subject.fare).to eq(Journey::PENALTY_FARE)
      end
    end

    context 'Exit station is equal to nil' do
        it 'Charges penalty fare for starting journey after starting journey' do
          2.times { subject.start_journey(station) }
          expect(subject.fare).to eq (Journey::PENALTY_FARE)
        end
      end
    end
end
