require "helper"

describe ActionDispatch::Request do
  describe 'request' do
    before :all do
      @request = FactoryGirl.build(:request)
    end

    it "should be" do
      @request.should be
    end

    context 'should respond to wiselinks methods' do
      it '#wiselinks?' do
        @request.should respond_to(:wiselinks?)
      end

      it '#wiselinks_template?' do
        @request.should respond_to(:wiselinks_template?)
      end

      it '#wiselinks_partial?' do
        @request.should respond_to(:wiselinks_partial?)
      end

      it '#wiselinks_panel?' do
        @request.should respond_to(:wiselinks_panel?)
      end
    end

    context 'wiselinks methods' do
      it 'should not be a wiselinks request' do
        @request.wiselinks?.should == false
      end

      it 'should not be a wiselinks template request' do
        @request.wiselinks_template?.should == false
      end

      it 'should not be a wiselinks partial request' do
        @request.wiselinks_partial?.should == false
      end

      it 'should not be a wiselinks panel request' do
        @request.wiselinks_panel?.should == false
      end
    end
  end

  describe 'wiselinks_request' do
    before :all do
      @request = FactoryGirl.build(:wiselinks_request)
    end

    it "should be" do
      @request.should be
    end

    context 'wiselinks methods' do
      it 'should be a wiselinks request' do
        @request.wiselinks?.should == true
      end

      it 'should be a wiselinks template request' do
        @request.wiselinks_template?.should == true
      end

      it 'should not be a wiselinks partial request' do
        @request.wiselinks_partial?.should == false
      end

      it 'should not be a wiselinks panel request' do
        @request.wiselinks_panel?.should == false
      end
    end
  end

  describe 'wiselinks_template_request' do
    before :all do
      @request = FactoryGirl.build(:wiselinks_template_request)
    end

    it "should be" do
      @request.should be
    end

    context 'wiselinks methods' do
      it 'should be a wiselinks request' do
        @request.wiselinks?.should == true
      end

      it 'should be a wiselinks template request' do
        @request.wiselinks_template?.should == true
      end

      it 'should not be a wiselinks partial request' do
        @request.wiselinks_partial?.should == false
      end

      it 'should not be a wiselinks panel request' do
        @request.wiselinks_panel?.should == false
      end
    end
  end

  describe 'wiselinks_partial_request' do
    before :all do
      @request = FactoryGirl.build(:wiselinks_partial_request)
    end

    it "should be" do
      @request.should be
    end

    context 'wiselinks methods' do
      it 'should be a wiselinks request' do
        @request.wiselinks?.should == true
      end

      it 'should not be a wiselinks template request' do
        @request.wiselinks_template?.should == false
      end

      it 'should be a wiselinks partial request' do
        @request.wiselinks_partial?.should == true
      end

      it 'should be a wiselinks panel request' do
        @request.wiselinks_panel?.should == false
      end
    end
  end

  describe 'wiselinks_panel_request' do
    before :all do
      @request = FactoryGirl.build(:wiselinks_panel_request)
    end

    it "should be" do
      @request.should be
    end

    context 'wiselinks methods' do
      it 'should be a wiselinks request' do
        @request.wiselinks?.should == true
      end

      it 'should not be a wiselinks template request' do
        @request.wiselinks_template?.should == false
      end

      it 'should be a wiselinks partial request' do
        @request.wiselinks_partial?.should == false
      end

      it 'should be a wiselinks panel request' do
        @request.wiselinks_panel?.should == true
      end
    end
  end



end
