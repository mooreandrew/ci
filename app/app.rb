require_relative 'base'


class Jobs < ActiveRecord::Base
end

class Sequences < ActiveRecord::Base
end

class Flows < ActiveRecord::Base
end


class MyApp < SinatraRecord


  get "/" do

    erb :index
  end

  get "/api/all" do
    data = {}
    data['flows'] = Flows.order("created_at DESC").as_json
    data['sequences'] = Sequences.order("created_at DESC").as_json
    data['jobs'] = Jobs.order("created_at DESC").as_json
    return data.to_json
  end

  get "/add" do
    @note = Jobs.new(:title => 'Sample Job', :sequence_id => '0')
    if @note.save
      return 'Added'
    else
      return 'Failed'
    end
  end

  get "/sample" do

    Jobs.delete_all
    Sequences.delete_all
    Flows.delete_all

    @flow0 = Flows.new(:title => 'Example #1', :order => 0)
    @flow0.save!
    @flow1 = Flows.new(:title => 'Orphaned', :order => 0)
    @flow1.save!

    @sequence0 = Sequences.new(:title => 'Orphaned', :order => 0, :stage => 0, :flow_id => @flow0.id)
    @sequence0.save!
    @sequence1 = Sequences.new(:title => 'Step 1a', :order => 0, :stage => 1, :flow_id => @flow1.id)
    @sequence1.save!
    @sequence2 = Sequences.new(:title => 'Step 1b', :order => 1, :stage => 1, :flow_id => @flow1.id)
    @sequence2.save!
    @sequence3 = Sequences.new(:title => 'Step 1c', :order => 2, :stage => 1, :flow_id => @flow1.id)
    @sequence3.save!
    @sequence4 = Sequences.new(:title => 'Step 2', :order => 0, :stage => 2, :flow_id => @flow1.id)
    @sequence4.save!
    @sequence5 = Sequences.new(:title => 'Step 3', :order => 0, :stage => 3, :flow_id => @flow1.id)
    @sequence5.save!

    Jobs.new(:title => 'Unit Test #1', :sequence_id => @sequence1.id, :order => 0).save
    Jobs.new(:title => 'Unit Test #2', :sequence_id => @sequence2.id, :order => 0).save
    Jobs.new(:title => 'Unit Test #3', :sequence_id => @sequence3.id, :order => 0).save
    Jobs.new(:title => 'Build Artifact', :sequence_id => @sequence4.id, :order => 0).save
    Jobs.new(:title => 'Deploy Artifact', :sequence_id => @sequence4.id, :order => 1).save
    Jobs.new(:title => 'Push Changes', :sequence_id => @sequence4.id, :order => 2).save
    Jobs.new(:title => 'Run Acceptance Tests', :sequence_id => @sequence5.id, :order => 0).save

    Jobs.new(:title => 'Orphaned Job #1', :sequence_id => @sequence0.id, :order => 0).save
    Jobs.new(:title => 'Orphaned Job #2', :sequence_id => @sequence0.id, :order => 1).save
    Jobs.new(:title => 'Orphaned Job #3', :sequence_id => @sequence0.id, :order => 2).save
    Jobs.new(:title => 'Orphaned Job #4', :sequence_id => @sequence0.id, :order => 3).save
    Jobs.new(:title => 'Orphaned Job #5', :sequence_id => @sequence0.id, :order => 4).save
    Jobs.new(:title => 'Orphaned Job #6', :sequence_id => @sequence0.id, :order => 5).save
    Jobs.new(:title => 'Orphaned Job #6', :sequence_id => @sequence0.id, :order => 6).save
    Jobs.new(:title => 'Orphaned Job #7', :sequence_id => @sequence0.id, :order => 7).save
    Jobs.new(:title => 'Orphaned Job #8', :sequence_id => @sequence0.id, :order => 8).save

    return 'Sample'
  end

end
