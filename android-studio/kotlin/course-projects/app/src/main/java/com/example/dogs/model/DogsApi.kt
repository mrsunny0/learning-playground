package com.example.dogs.model

import io.reactivex.Single
import retrofit2.http.GET

// retrofit API calls
interface DogsApi {
    @GET("/DevTides/DogsApi/master/dogs.json")
    fun getDogs(): Single<List<DogBreed>>
}