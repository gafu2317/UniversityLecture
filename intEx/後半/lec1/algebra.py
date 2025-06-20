#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
第1回演習問題
"""
import numpy as np

########## 課題1(a)

print("Hello, World!")

########## 課題1(b)i

A = np.arange(1, 21, dtype=float).reshape(4, 5)
print("A = ", A)
b = np.array([1, 0, 1, 0, 1], dtype=float)
print("b = ", b)

########## 課題1(b)ii

Ab = A @ b 
print("Ab = ", Ab)

########## 課題1(b)iii

column_sum = A.sum(axis=0)
print("column_sum = ", column_sum)
row_sum = A.sum(axis=1)
print("row_sum = ", row_sum)

########## 課題1(c) 例
# print("--- Kadai 1(c) example ---")
# x = 0
# for n in range(1, 11): # この指定でnは1から10まで動く
#     x = 2*x + 1
#     print("a(", n, ") =", x)
    
########## 課題1(c)

print("--- Kadai 1(c) ---")
x = 6
for n in range(1, 11): # この指定でnは1から10まで動く
    if n % 2 == 0:
        x = x/2
    else:
        x = 3*x + 1
    print("a(", n, ") =", x)

