package com.example.noworderfoodapp.view.fragment;

import android.content.Intent;
import android.util.Log;
import android.widget.LinearLayout;

import androidx.lifecycle.Observer;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.noworderfoodapp.App;
import com.example.noworderfoodapp.R;
import com.example.noworderfoodapp.databinding.FragmentHomeShoeBinding;
import com.example.noworderfoodapp.databinding.FragmentOrderBinding;
import com.example.noworderfoodapp.entity.Banner;
import com.example.noworderfoodapp.entity.Category;
import com.example.noworderfoodapp.entity.Orders;
import com.example.noworderfoodapp.entity.Products;
import com.example.noworderfoodapp.entity.Shop;
import com.example.noworderfoodapp.view.act.OrderDetailActivity;
import com.example.noworderfoodapp.view.adapter.BannerAdapter;
import com.example.noworderfoodapp.view.adapter.CategoryAdapter;
import com.example.noworderfoodapp.view.adapter.OrderAdapter;
import com.example.noworderfoodapp.view.adapter.ProductAdapter;
import com.example.noworderfoodapp.view.adapter.ShopAdapter;
import com.example.noworderfoodapp.viewmodel.HomeShoeViewModel;
import com.example.noworderfoodapp.viewmodel.OrderViewModel;

import java.util.ArrayList;
import java.util.List;

public class HomeShoeFragment extends BaseFragment<FragmentHomeShoeBinding, HomeShoeViewModel> implements CategoryAdapter.OnItemClick , ProductAdapter.OnItemClick{
    private ShopAdapter shopAdapter;
    private BannerAdapter bannerAdapter;
    private List<Shop> listShop;
    private List<Banner> listBanner;
    @Override
    protected Class<HomeShoeViewModel> getViewModelClass() {
        return HomeShoeViewModel.class;
    }

    @Override
    protected int getLayoutId() {
        return R.layout.fragment_home_shoe;
    }

    @Override
    protected void initViews() {
        Log.i("KMFG", "initViews:fragment_order ");
        listShop = new ArrayList<>();
        listBanner = new ArrayList<>();
        mViewModel.getListBanner();
        mViewModel.getListShopServer();
        mViewModel.getBannerMutableLiveData().observe(this, new Observer<List<Banner>>() {
            @Override
            public void onChanged(List<Banner> categories) {
                listBanner.clear();
                listBanner.addAll(categories);
                bannerAdapter.notifyDataSetChanged();
            }
        });
        mViewModel.getShopMutableLiveData().observe(this, new Observer<List<Shop>>() {
            @Override
            public void onChanged(List<Shop> products) {
                listShop.clear();
                listShop.addAll(products);
                shopAdapter.notifyDataSetChanged();
            }
        });
        bannerAdapter = new BannerAdapter(listBanner,getContext());
        LinearLayoutManager manager = new LinearLayoutManager(getContext(),  RecyclerView.HORIZONTAL,false);
        binding.rcvBannerShoe.setLayoutManager(manager);
        binding.rcvBannerShoe.setAdapter(bannerAdapter);
       // bannerAdapter.setOnItemClick(this);

        shopAdapter = new ShopAdapter(listShop,getContext());
        GridLayoutManager gridLayoutManager = new GridLayoutManager(getContext(), 2);
        binding.rcvShopShoe.setLayoutManager(gridLayoutManager);
        binding.rcvShopShoe.setAdapter(shopAdapter);
      //  shopAdapter.setOnItemClick(this);
    }

    @Override
    public void onItemClick(Category orders) {
        Intent intent = new Intent(getActivity(), OrderDetailActivity.class);
        intent.putExtra("order",orders);
        startActivity(intent);
    }

    @Override
    public void onItemClick(Products products) {
        Intent intent = new Intent(getActivity(), OrderDetailActivity.class);
        intent.putExtra("order",products);
        startActivity(intent);
    }
    @Override
    public void onResume() {
        super.onResume();
        mViewModel.getListBanner();
        mViewModel.getListShopServer();
        mViewModel.getBannerMutableLiveData().observe(this, new Observer<List<Banner>>() {
            @Override
            public void onChanged(List<Banner> categories) {
                listBanner.clear();
                listBanner.addAll(categories);
                bannerAdapter.notifyDataSetChanged();
            }
        });
        mViewModel.getShopMutableLiveData().observe(this, new Observer<List<Shop>>() {
            @Override
            public void onChanged(List<Shop> products) {
                listShop.clear();
                listShop.addAll(products);
                shopAdapter.notifyDataSetChanged();
            }
        });
    }
}
