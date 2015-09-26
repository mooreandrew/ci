require_relative 'base'


class Jobs < ActiveRecord::Base
end

class Sequences < ActiveRecord::Base
end

class Flows < ActiveRecord::Base
end

class Stages < ActiveRecord::Base
end


class MyApp < SinatraRecord


  get "/" do

    erb :index
  end

  get "/api/all" do
    data = {}
    data['flows'] = Flows.order("'order' asc").as_json
    data['stages'] = Stages.order("'order' asc").as_json
    data['sequences'] = Sequences.order("'order' asc").as_json
    data['jobs'] = Jobs.order("'order' asc").as_json
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

    @flow1 = Flows.new(:title => 'Example #1', :order => 0)
    @flow1.save!
    @flow2 = Flows.new(:title => 'Orphaned', :order => 1)
    @flow2.save!


    @stage1 = Stages.new(:title => 'Example #1', :order => 0, :flow_id => @flow1.id)
    @stage1.save!
    @stage2 = Stages.new(:title => 'Example #1', :order => 1, :flow_id => @flow1.id)
    @stage2.save!
    @stage3 = Stages.new(:title => 'Example #1', :order => 2, :flow_id => @flow1.id)
    @stage3.save!


    @sequence1 = Sequences.new(:title => 'Step 1a', :order => 0, :stage_id => @stage1.id)
    @sequence1.save!
    @sequence2 = Sequences.new(:title => 'Step 1b', :order => 1, :stage_id => @stage1.id)
    @sequence2.save!
    @sequence3 = Sequences.new(:title => 'Step 1c', :order => 2, :stage_id => @stage1.id)
    @sequence3.save!
    @sequence4 = Sequences.new(:title => 'Step 2', :order => 0, :stage_id => @stage2.id)
    @sequence4.save!
    @sequence5 = Sequences.new(:title => 'Step 3', :order => 0, :stage_id => @stage3.id)
    @sequence5.save!




    Jobs.new(:title => 'Unit Test #1', :sequence_id => @sequence1.id, :order => 0).save
    Jobs.new(:title => 'Unit Test #2', :sequence_id => @sequence2.id, :order => 0).save
    Jobs.new(:title => 'Unit Test #3', :sequence_id => @sequence3.id, :order => 0).save
    Jobs.new(:title => 'Build Artifact', :sequence_id => @sequence4.id, :order => 0).save
    Jobs.new(:title => 'Deploy Artifact', :sequence_id => @sequence4.id, :order => 1).save
    Jobs.new(:title => 'Push Changes', :sequence_id => @sequence4.id, :order => 2).save
    Jobs.new(:title => 'Run Acceptance Tests', :sequence_id => @sequence5.id, :order => 0).save

    Jobs.new(:title => 'Orphaned Job #1', :sequence_id => 0, :order => 0).save
    Jobs.new(:title => 'Orphaned Job #2', :sequence_id => 0, :order => 1).save
    Jobs.new(:title => 'Orphaned Job #3', :sequence_id => 0, :order => 2).save
    Jobs.new(:title => 'Orphaned Job #4', :sequence_id => 0, :order => 3).save
    Jobs.new(:title => 'Orphaned Job #5', :sequence_id => 0, :order => 4).save
    Jobs.new(:title => 'Orphaned Job #6', :sequence_id => 0, :order => 5).save
    Jobs.new(:title => 'Orphaned Job #6', :sequence_id => 0, :order => 6).save
    Jobs.new(:title => 'Orphaned Job #7', :sequence_id => 0, :order => 7).save
    Jobs.new(:title => 'Orphaned Job #8', :sequence_id => 0, :order => 8).save

    return 'Sample'
  end

end
