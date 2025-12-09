



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


local function main()
   print("=== TL版 Luaの特徴的機能デモ ===")
   print()

   demo_array()
   demo_hash()
   demo_mixed_table()
   demo_first_class_functions()
   demo_oop()
   demo_teal_module()

   print("=== デモ終了 ===")
end


local module = {
   main = main,
   MathUtils = MathUtils,
   Person = Person,
   Student = Student,
}

return module
