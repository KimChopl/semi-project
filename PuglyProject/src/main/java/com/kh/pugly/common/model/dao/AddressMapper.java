package com.kh.pugly.common.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.pugly.common.model.vo.Address;

@Mapper
public interface AddressMapper {

	Address selectAddress(Long addressNo);

	void insertAddress(Address ad);
	
}
