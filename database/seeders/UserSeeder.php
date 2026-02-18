<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run()
    {
        User::create([
            'name' => 'Admin',
            'email' => 'gestionnaire@exemple.com',
            'password' => Hash::make('password'), // mot de passe haché
            'role' => 'admin', // si tu veux définir un rôle par défaut
        ]);
    }
}
