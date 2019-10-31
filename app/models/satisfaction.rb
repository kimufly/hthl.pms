class Satisfaction < ApplicationRecord
    SATISFACTION = %i[quite_satisfied satisfaction ordinary dissatisfaction very_disgruntled]
    enum service_type: %i[fault_handling health_examination network_changes other]
    enum complaints_hotline: %i[know be_ignorant]
    enum service_engineer: %i[excellent fine centre difference]

    
    enum service_quality: SATISFACTION, _prefix: :service_quality
    enum engineer: SATISFACTION, _prefix: :engineer
    enum technical_support: SATISFACTION, _prefix: :technical_support
    enum sales_service: SATISFACTION, _prefix: :sales_service
    enum customer_eturn_visit: SATISFACTION, _prefix: :customer_eturn_visit

       
    belongs_to :project
    accepts_nested_attributes_for :project
end
