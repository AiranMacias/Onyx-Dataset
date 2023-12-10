SELECT transactionid
,DATE(date) as date
,time
,date_trunc('hour', time) + 
 CASE 
    WHEN EXTRACT(minute FROM time) < 30 THEN interval '0 minutes'
  	ELSE interval '30 minutes'
 END AS rounded_time
, customerid as customer_id
,age
,gender
, CONCAT('City ', SUBSTRING(location FROM 5)::integer) AS location
,storeid as store_id
,onlineorderflag as online_order_flag
,CASE
	WHEN onlineorderflag = TRUE
	then 'online'
		ELSE 'store'
END AS mode_of_order
,productid as product_id
,CONCAT(
	SUBSTRING(productname FROM 1 FOR LENGTH(productname) - 7),
	' ', SUBSTRING(productname FROM LENGTH(productname) - 6))  as product_name
,category
,quantity
,round(unitprice::numeric,2) as unit_price
,round(totalprice::numeric, 2) as total_price
,paymenttype as payment_type
,promotionapplied as promotion_applied
,CASE
	WHEN giftwrap = TRUE
	then 'yes'
	ELSE 'no'
END as gift_wrap
,CASE 
	WHEN shippingmethod is null
	then 'Bought at store'
	ELSE shippingmethod
END AS shipping_method
,CASE
    WHEN deliverytime = 0
    THEN 'Store Bought'
    ELSE CONCAT(deliverytime, ' days')
END AS delivery_time
,weather
,CASE 
	WHEN event is null
	then 'No Event'
else event
END AS event
,customersatisfaction as customer_satisfaction
,CASE
	WHEN returnflag = TRUE
	then 'Returned'
ElSE 'Kept'
END as Returned
FROM onyx;
