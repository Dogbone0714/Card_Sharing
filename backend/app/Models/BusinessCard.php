<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class BusinessCard extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'name',
        'title',
        'company',
        'email',
        'phone',
        'website',
        'avatar',
        'bio',
        'social_links',
        'custom_fields',
        'theme',
        'is_public',
    ];

    protected $casts = [
        'social_links' => 'array',
        'custom_fields' => 'array',
        'is_public' => 'boolean',
    ];

    protected $hidden = [
        'user_id',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function getQrCodeUrlAttribute(): string
    {
        return route('cards.qr', $this->id);
    }

    public function getPublicUrlAttribute(): string
    {
        return route('cards.public', $this->id);
    }

    public function scopePublic($query)
    {
        return $query->where('is_public', true);
    }

    public function scopeByUser($query, $userId)
    {
        return $query->where('user_id', $userId);
    }
}
