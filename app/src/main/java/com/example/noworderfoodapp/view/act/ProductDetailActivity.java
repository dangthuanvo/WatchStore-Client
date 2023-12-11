package com.example.noworderfoodapp.view.act;

import android.util.Log;

import androidx.lifecycle.Observer;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.noworderfoodapp.R;
import com.example.noworderfoodapp.databinding.ActivityProductDetailBinding;
import com.example.noworderfoodapp.entity.Banner;
import com.example.noworderfoodapp.entity.ProductReview;
import com.example.noworderfoodapp.entity.Products;
import com.example.noworderfoodapp.entity.Shop;
import com.example.noworderfoodapp.view.adapter.BannerAdapter;
import com.example.noworderfoodapp.view.adapter.ProductReviewAdapter;
import com.example.noworderfoodapp.viewmodel.ProductDetailViewModel;

import java.util.ArrayList;
import java.util.List;

public class ProductDetailActivity extends BaseActivity<ActivityProductDetailBinding, ProductDetailViewModel> {
    private ProductReviewAdapter productReviewAdapter;
    private List<ProductReview> productReviewList;
    @Override
    protected Class<ProductDetailViewModel> getViewModelClass() {
        return ProductDetailViewModel.class;
    }

    @Override
    protected int getLayoutId() {
        return R.layout.activity_product_detail;
    }

    @Override
    protected void initViews() {
        Products data = (Products) getIntent().getSerializableExtra("product_detail");
        binding.tvProductName.setText(data.getName());
        binding.tvProductPrice.setText(data.getPrice()+"Đ");
        if (data.getProductReviews().isEmpty() || data.getProductReviews() != null) {
            binding.tvProductVote.setText(data.getProductReviews().get(0).getRating()+"");
            Log.i("KMFG", "initViews:fragment_order ");
            productReviewList = new ArrayList<>();
            productReviewList.addAll(data.getProductReviews());
            productReviewAdapter = new ProductReviewAdapter(productReviewList,this);
            LinearLayoutManager manager = new LinearLayoutManager(this);
            binding.rcvComment.setLayoutManager(manager);
            binding.rcvComment.setAdapter(productReviewAdapter);
        }
    }


    @Override
    protected void onResume() {
        super.onResume();
    }

    @Override
    public void callBack(String key, Object data) {

    }
}
