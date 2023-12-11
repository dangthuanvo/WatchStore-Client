package com.example.noworderfoodapp.api;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.module.SimpleModule;

import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;
import retrofit2.converter.jackson.JacksonConverterFactory;

public class ApiClient {
    private static Retrofit retrofit;
    public static String BASE_URL = "http://192.168.21.214:8080";
   //  public static String BASE_URL = "http://172.21.64.1:8080";
  //  public static String BASE_URL = "http://192.168.43.146:8080";
   public static Retrofit getRetrofitInstance() {
       if (retrofit == null) {
           ObjectMapper objectMapper = new ObjectMapper();
           objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

           SimpleModule module = new SimpleModule();
           module.addDeserializer(Object.class, new CustomJsonDeserializer());
           objectMapper.registerModule(module);

           retrofit = new Retrofit.Builder()
                   .baseUrl(BASE_URL)
                   .addConverterFactory(JacksonConverterFactory.create(objectMapper))
                   .build();
       }
       return retrofit;
   }
}