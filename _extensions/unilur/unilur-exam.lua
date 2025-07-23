local mcq_style = "oneparcheckboxes"
local show_id = true
local logo_path = "logo.png" -- Customize with your file name
local inserted_logo = false

-- 🧮 Handle MCQ formatting
function Div(el)
  if el.classes:includes("unilur-mcq") then
    -- Choose rendering style
    if mcq_style == "inline-radiobuttons" then
      table.insert(el.classes, "inline-radio")
    elseif mcq_style == "oneparcheckboxes" then
      table.insert(el.classes, "checkbox-style")
    end

    -- Optional scoring block
    table.insert(el.content, pandoc.Para{
      pandoc.Emph{pandoc.Str("Score: ______ / ____")}
    })

    -- Label MCQ section
    table.insert(el.content, 1, pandoc.Para{
      pandoc.Strong{pandoc.Str("Multiple Choice")}
    })

    return el
  end
end

-- 🆔 Add Student ID and Logo before first-level header
function Header(el)
  if show_id and el.level == 1 and not inserted_logo then
    inserted_logo = true

    local logo_block = pandoc.Para{
      pandoc.Image("Institution Logo", logo_path)
    }

    local id_block = pandoc.Para{
      pandoc.Emph{pandoc.Str("Student ID: __________________")}
    }

    return {logo_block, id_block, el}
  end
end

return {
  {Div = Div},
  {Header = Header}
}

