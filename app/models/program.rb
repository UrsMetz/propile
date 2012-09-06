class Program < ActiveRecord::Base
  attr_accessible :version
  attr_accessible :avgpaf
  has_many :program_entries

  def getProgramEntryMatrix # rows=slots, cols=tracks
    matrix = Hash.new
    program_entries.each do |pe|
      matrix[[pe.slot, pe.track]] = pe
    end
    matrix
  end

  def calculatePaf
    self.avgpaf = calculateAvgPafForPresenters(Presenter.all)
  end

  def calculateAvgPafForPresenters(presenters)
    return 0 unless presenters and not presenters.empty?
    pafPerPresenter = calculatePafForPresenters(presenters)
    pafPerPresenter.inject {|sum,x| sum+x}  / pafPerPresenter.size
  end

  def calculatePafForPresenters(presenters)
    pafPerPresenter = []
    presenters.each do |presenter|
      pafPerPresenter.append calculatePafForOnePresenter(presenter.votes)
    end 
    pafPerPresenter
  end

  def calculatePafForOnePresenter(votes_by_presenter)
    slotsForPresenter = Set.new
    votes_by_presenter.each do |vote| 
      if program_entries.exists? :session_id => vote.session.id
        slotsForPresenter << program_entries.where(:session_id => vote.session.id).first.slot
      end
    end
    slotsForPresenter.size
  end

end