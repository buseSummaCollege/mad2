<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('champion_hobby', function (Blueprint $table) {
            $table->foreignId('champion_id')->constrained('champions')->restrictOnDelete();
            $table->foreignId('hobby_id')->constrained('hobbies')->restrictOnDelete();
            $table->primary(['champion_id', 'hobby_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('champion_hobby');
    }
};


