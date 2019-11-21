module ApplicationHelper
    def menu_open cont_name
        if [*cont_name].any? controller_name
        [{class: "menu-open"},{style: "display: block;"}]
        else 
            [{}, {}]
        end
    end
end
