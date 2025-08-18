<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\BusinessCard;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use SimpleSoftwareIO\QrCode\Facades\QrCode;

class BusinessCardController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:sanctum')->except(['show', 'scan', 'qr']);
    }

    /**
     * 獲取用戶的名片
     */
    public function show(string $id): JsonResponse
    {
        $card = BusinessCard::findOrFail($id);
        
        if (!$card->is_public && Auth::id() !== $card->user_id) {
            return response()->json(['message' => '名片不存在'], 404);
        }

        return response()->json($card);
    }

    /**
     * 掃描名片
     */
    public function scan(string $id): JsonResponse
    {
        $card = BusinessCard::findOrFail($id);
        
        if (!$card->is_public) {
            return response()->json(['message' => '名片不存在'], 404);
        }

        return response()->json($card);
    }

    /**
     * 獲取名片的QR Code
     */
    public function qr(string $id): JsonResponse
    {
        $card = BusinessCard::findOrFail($id);
        
        $qrCode = QrCode::size(300)
            ->format('svg')
            ->generate($card->public_url);

        return response()->json([
            'qr_code' => $qrCode,
            'card_url' => $card->public_url
        ]);
    }

    /**
     * 創建或更新名片
     */
    public function store(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'title' => 'required|string|max:255',
            'company' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'phone' => 'required|string|max:20',
            'website' => 'nullable|url|max:255',
            'bio' => 'nullable|string|max:1000',
            'social_links' => 'nullable|array',
            'social_links.*' => 'url|max:255',
            'custom_fields' => 'nullable|array',
            'theme' => 'nullable|string|max:50',
            'is_public' => 'boolean',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => '驗證失敗',
                'errors' => $validator->errors()
            ], 422);
        }

        $userId = Auth::id();
        
        // 檢查是否已有名片
        $existingCard = BusinessCard::where('user_id', $userId)->first();
        
        if ($existingCard) {
            // 更新現有名片
            $existingCard->update($request->all());
            $card = $existingCard;
        } else {
            // 創建新名片
            $card = BusinessCard::create(array_merge(
                $request->all(),
                ['user_id' => $userId]
            ));
        }

        return response()->json([
            'message' => $existingCard ? '名片已更新' : '名片已創建',
            'card' => $card
        ], $existingCard ? 200 : 201);
    }

    /**
     * 獲取用戶的名片列表
     */
    public function index(): JsonResponse
    {
        $cards = BusinessCard::where('user_id', Auth::id())->get();
        
        return response()->json($cards);
    }

    /**
     * 刪除名片
     */
    public function destroy(string $id): JsonResponse
    {
        $card = BusinessCard::where('user_id', Auth::id())
            ->findOrFail($id);

        $card->delete();

        return response()->json(['message' => '名片已刪除']);
    }

    /**
     * 更新名片
     */
    public function update(Request $request, string $id): JsonResponse
    {
        $card = BusinessCard::where('user_id', Auth::id())
            ->findOrFail($id);

        $validator = Validator::make($request->all(), [
            'name' => 'sometimes|required|string|max:255',
            'title' => 'sometimes|required|string|max:255',
            'company' => 'sometimes|required|string|max:255',
            'email' => 'sometimes|required|email|max:255',
            'phone' => 'sometimes|required|string|max:20',
            'website' => 'nullable|url|max:255',
            'bio' => 'nullable|string|max:1000',
            'social_links' => 'nullable|array',
            'social_links.*' => 'url|max:255',
            'custom_fields' => 'nullable|array',
            'theme' => 'nullable|string|max:50',
            'is_public' => 'sometimes|boolean',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => '驗證失敗',
                'errors' => $validator->errors()
            ], 422);
        }

        $card->update($request->all());

        return response()->json([
            'message' => '名片已更新',
            'card' => $card
        ]);
    }
}
