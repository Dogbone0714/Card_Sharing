<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\BusinessCardController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

// 主页面
Route::get('/', function () {
    return view('welcome');
});

// API 文档页面
Route::get('/api-docs', function () {
    return view('api-docs');
});

// 名片展示页面
Route::get('/card/{id}', function ($id) {
    return view('card-show', ['cardId' => $id]);
});

// 健康检查
Route::get('/health', function () {
    return response()->json(['status' => 'healthy', 'timestamp' => now()]);
});

// 前端应用入口（SPA 支持）
Route::get('/app/{any?}', function () {
    return view('app');
})->where('any', '.*');
