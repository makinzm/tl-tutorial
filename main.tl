-- TL版 Luaの特徴的機能デモ
-- 1. Table風のデータ構造

-- 配列風の使い方
local function demo_array()
    local arr = {3, 2, 1}
    print("Array demo:")
    print("arr[1] =", arr[1])  -- 出力: 3
    print("arr[2] =", arr[2])  -- 出力: 2
    print("arr[3] =", arr[3])  -- 出力: 1
    print()
end

-- ハッシュテーブル風の使い方
local function demo_hash()
    local person = {
        name = "Alice",
        age = 30
    }
    print("Hash table demo:")
    print("person.name =", person.name)  -- 出力: Alice
    print("person.age =", person.age)    -- 出力: 30
    print()
end

-- 混合テーブル（配列とハッシュの組み合わせ）
local function demo_mixed_table()
    local mixed = {
        "first",   -- arr[1] 
        "second",  -- arr[2]
        name = "Mixed Table",
        count = 2
    }
    print("Mixed table demo:")
    print("mixed[1] =", mixed[1])
    print("mixed[2] =", mixed[2])
    print("mixed.name =", mixed.name)
    print("mixed.count =", mixed.count)
    print()
end

-- 2. First-class関数のデモ
local function demo_first_class_functions()
    print("First-class functions demo:")
    
    -- 関数を変数に代入
    local add = function(x: number, y: number): number
        return x + y
    end
    
    -- 関数を引数として渡す
    local function apply_operation(a: number, b: number, op: function(number, number): number): number
        return op(a, b)
    end
    
    -- 関数を戻り値として返す
    local function make_multiplier(factor: number): function(number): number
        return function(x: number): number
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

-- 3. オブジェクト指向プログラミングのデモ（TLのrecordを使用）
local record Person
    name: string
    age: number
end

-- Personのコンストラクタ（ドキュメント通りの実装）
function Person.new(name: string, age: number): Person
    local self: Person = setmetatable({}, { __index = Person })
    self.name = name or ""
    self.age = age or 0
    return self
end

-- Personのメソッド実装
function Person:greet(): string
    return "Hello, my name is " .. self.name .. " and I am " .. tostring(self.age) .. " years old."
end

function Person:show_age(): number
    return self.age
end

local record Student
    name: string
    age: number
    student_id: string
end

-- Studentのコンストラクタ（Personを継承）
function Student.new(name: string, age: number, student_id: string): Student
    local self: Student = setmetatable({}, { __index = Student })
    self.name = name or ""
    self.age = age or 0
    self.student_id = student_id or ""
    return self
end

-- Studentのメソッド実装
function Student:greet(): string
    return "Hello, my name is " .. self.name .. " and I am " .. tostring(self.age) .. " years old. I am also a student with ID " .. self.student_id .. "."
end

function Student:show_age(): number
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

-- 4. TealからLuaへの読み込みデモ用のモジュール
local record MathUtils
    add: function(number, number): number
    multiply: function(number, number): number
end

function MathUtils.add(x: number, y: number): number
    return x + y
end

function MathUtils.multiply(x: number, y: number): number
    return x * y
end

local function demo_teal_module()
    print("Teal module demo:")
    print("MathUtils.add(5, 3) =", MathUtils.add(5, 3))
    print("MathUtils.multiply(4, 7) =", MathUtils.multiply(4, 7))
    print()
end

-- 5. Result型を使ったエラーハンドリングのデモ
local type Result<T> = record
    success: boolean
    value: T
    error: string
end

-- 成功結果を作成するヘルパー関数
local function ok<T>(value: T): Result<T>
    return {
        success = true,
        value = value,
        error = ""
    }
end

-- 失敗結果を作成するヘルパー関数
local function err<T>(error_msg: string): Result<T>
    return {
        success = false,
        value = nil,
        error = error_msg
    } as Result<T>
end

-- 割り算関数（ゼロ除算をエラーとして扱う）
local function safe_divide(a: number, b: number): Result<number>
    if b == 0 then
        return err("ゼロで除算しようとしました") as Result<number>
    end
    return ok(a / b)
end

-- 数値の平方根関数（負数をエラーとして扱う）
local function safe_sqrt(x: number): Result<number>
    if x < 0 then
        return err("負数の平方根は計算できません") as Result<number>
    end
    return ok(math.sqrt(x))
end

-- Resultをチェーンする関数（mapメソッドのようなもの）
local function map_result<T, U>(result: Result<T>, func: function(T): U): Result<U>
    if result.success then
        return ok(func(result.value))
    else
        return err(result.error) as Result<U>
    end
end

local function demo_result_type()
    print("Result type demo:")
    
    -- 成功例
    local result1 = safe_divide(10, 2)
    if result1.success then
        print("成功: 10 / 2 =", result1.value)
    else
        print("エラー:", result1.error)
    end
    
    -- 失敗例
    local result2 = safe_divide(10, 0)
    if result2.success then
        print("成功: 10 / 0 =", result2.value)
    else
        print("エラー:", result2.error)
    end
    
    -- 平方根の例
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
    
    -- Resultのチェーン例
    local chained = map_result(safe_sqrt(25), function(x: number): number
        return x * 2
    end)
    if chained.success then
        print("チョーン成功: sqrt(25) * 2 =", chained.value)
    else
        print("チェーンエラー:", chained.error)
    end
    
    print()
end

-- メイン関数
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
    
    print("=== デモ終了 ===")
end



-- このモジュールをエクスポート（Luaから使用可能にする）
local module = {
    main = main,
    MathUtils = MathUtils,
    Person = Person,
    Student = Student,
    safe_divide = safe_divide,
    safe_sqrt = safe_sqrt,
    ok = ok,
    err = err
}

return module
