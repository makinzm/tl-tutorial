local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local math = _tl_compat and _tl_compat.math or math



local function demo_array()
   local arr = { 3, 2, 1 }
   print("Array demo:")
   print("arr[1] =", arr[1])
   print("arr[2] =", arr[2])
   print("arr[3] =", arr[3])
   print()
end


local function demo_hash()
   local person = {
      name = "Alice",
      age = 30,
   }
   print("Hash table demo:")
   print("person.name =", person.name)
   print("person.age =", person.age)
   print()
end


local function demo_mixed_table()
   local mixed = {
      "first",
      "second",
      name = "Mixed Table",
      count = 2,
   }
   print("Mixed table demo:")
   print("mixed[1] =", mixed[1])
   print("mixed[2] =", mixed[2])
   print("mixed.name =", mixed.name)
   print("mixed.count =", mixed.count)
   print()
end


local function demo_first_class_functions()
   print("First-class functions demo:")


   local add = function(x, y)
      return x + y
   end


   local function apply_operation(a, b, op)
      return op(a, b)
   end


   local function make_multiplier(factor)
      return function(x)
         return x * factor
      end
   end

   local result1 = add(2, 3)
   print("add(2, 3) =", result1)

   local result2 = apply_operation(5, 4, add)
   print("apply_operation(5, 4, add) =", result2)

   local double = make_multiplier(2)
   local result3 = double(7)
   print("double(7) =", result3)

   print()
end


local Person = {}








function Person.new(name, age)
   local self = setmetatable({}, { __index = Person })
   self.name = name or ""
   self.age = age or 0
   return self
end


function Person:greet()
   return "Hello, my name is " .. self.name .. " and I am " .. tostring(self.age) .. " years old."
end

function Person:show_age()
   return self.age
end

local Student = {}









function Student.new(name, age, student_id)
   local self = setmetatable({}, { __index = Student })
   self.name = name or ""
   self.age = age or 0
   self.student_id = student_id or ""
   return self
end


function Student:greet()
   return "Hello, my name is " .. self.name .. " and I am " .. tostring(self.age) .. " years old. I am also a student with ID " .. self.student_id .. "."
end

function Student:show_age()
   return self.age
end

local function demo_oop()
   print("Object-oriented programming demo:")

   local alice = Student.new("Alice", 20, "S12345")
   print(alice:greet())
   print("Age:", alice:show_age())

   local bob = Person.new("Bob", 25)
   print(bob:greet())
   print()
end


local MathUtils = {}




function MathUtils.add(x, y)
   return x + y
end

function MathUtils.multiply(x, y)
   return x * y
end

local function demo_teal_module()
   print("Teal module demo:")
   print("MathUtils.add(5, 3) =", MathUtils.add(5, 3))
   print("MathUtils.multiply(4, 7) =", MathUtils.multiply(4, 7))
   print()
end









local function ok(value)
   return {
      success = true,
      value = value,
      error = "",
   }
end


local function err(error_msg)
   return {
      success = false,
      value = nil,
      error = error_msg,
   }
end


local function safe_divide(a, b)
   if b == 0 then
      return err("ゼロで除算しようとしました")
   end
   return ok(a / b)
end


local function safe_sqrt(x)
   if x < 0 then
      return err("負数の平方根は計算できません")
   end
   return ok(math.sqrt(x))
end


local function map_result(result, func)
   if result.success then
      return ok(func(result.value))
   else
      return err(result.error)
   end
end

local function demo_result_type()
   print("Result type demo:")


   local result1 = safe_divide(10, 2)
   if result1.success then
      print("成功: 10 / 2 =", result1.value)
   else
      print("エラー:", result1.error)
   end


   local result2 = safe_divide(10, 0)
   if result2.success then
      print("成功: 10 / 0 =", result2.value)
   else
      print("エラー:", result2.error)
   end


   local result3 = safe_sqrt(16)
   if result3.success then
      print("成功: sqrt(16) =", result3.value)
   else
      print("エラー:", result3.error)
   end

   local result4 = safe_sqrt(-4)
   if result4.success then
      print("成功: sqrt(-4) =", result4.value)
   else
      print("エラー:", result4.error)
   end


   local chained = map_result(safe_sqrt(25), function(x)
      return x * 2
   end)
   if chained.success then
      print("チョーン成功: sqrt(25) * 2 =", chained.value)
   else
      print("チェーンエラー:", chained.error)
   end

   print()
end



























local GameController = {}



function GameController.new()
   local self = setmetatable({}, { __index = GameController })
   self.current_state = "MENU"
   return self
end

function GameController:transition_to(new_state)
   print("状態遷移: " .. self.current_state .. " -> " .. new_state)
   self.current_state = new_state
end

function GameController:get_state_message()
   if self.current_state == "MENU" then
      return "メニュー画面です"
   elseif self.current_state == "PLAYING" then
      return "ゲームプレイ中です"
   elseif self.current_state == "PAUSED" then
      return "ゲームが一時停止中です"
   elseif self.current_state == "GAME_OVER" then
      return "ゲームオーバーです"
   else
      return "不明な状態です"
   end
end


local function handle_http_response(status)
   if status == "OK" then
      return "200: リクエストが成功しました"
   elseif status == "NOT_FOUND" then
      return "404: リソースが見つかりません"
   elseif status == "INTERNAL_ERROR" then
      return "500: サーバー内部エラーです"
   elseif status == "BAD_REQUEST" then
      return "400: 不正なリクエストです"
   else
      return "不明なステータスです"
   end
end


local Logger = {}



function Logger.new(min_level)
   local self = setmetatable({}, { __index = Logger })
   self.min_level = min_level or "INFO"
   return self
end


local function get_log_level_priority(level)
   if level == "DEBUG" then return 1
   elseif level == "INFO" then return 2
   elseif level == "WARN" then return 3
   elseif level == "ERROR" then return 4
   else return 0
   end
end

function Logger:log(level, message)
   if get_log_level_priority(level) >= get_log_level_priority(self.min_level) then
      print("[" .. level .. "] " .. message)
   end
end

local function demo_enums()
   print("Enum types demo:")


   print("1. ゲーム状態管理:")
   local game = GameController.new()
   print(game:get_state_message())

   game:transition_to("PLAYING")
   print(game:get_state_message())

   game:transition_to("PAUSED")
   print(game:get_state_message())

   game:transition_to("GAME_OVER")
   print(game:get_state_message())

   print()


   print("2. HTTPステータスハンドリング:")
   print(handle_http_response("OK"))
   print(handle_http_response("NOT_FOUND"))
   print(handle_http_response("INTERNAL_ERROR"))
   print(handle_http_response("BAD_REQUEST"))

   print()


   print("3. ログシステム:")
   local logger = Logger.new("INFO")

   logger:log("DEBUG", "このメッセージは表示されません")
   logger:log("INFO", "情報メッセージです")
   logger:log("WARN", "警告メッセージです")
   logger:log("ERROR", "エラーメッセージです")

   print()
end


local function main()
   print("=== TL版 Luaの特徴的機能デモ ===")
   print()

   demo_array()
   demo_hash()
   demo_mixed_table()
   demo_first_class_functions()
   demo_oop()
   demo_teal_module()
   demo_result_type()
   demo_enums()

   print("=== デモ終了 ===")
end




local module = {
   main = main,
   MathUtils = MathUtils,
   Person = Person,
   Student = Student,
   safe_divide = safe_divide,
   safe_sqrt = safe_sqrt,
   ok = ok,
   err = err,
   GameController = GameController,
   Logger = Logger,
   handle_http_response = handle_http_response,
}

return module
