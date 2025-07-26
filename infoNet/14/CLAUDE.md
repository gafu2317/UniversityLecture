# CLAUDE.md

日本語で答えて

##　課題内容

端末Aから端末Bへ、TCPでデータを一方的に伝送する場合を想定しています。この通信は、128 kbit/secの全二重静止衛星通信回線を利用し、端末AとBはそれぞれ別の衛星地球局に直結しています。
設定条件
• 回線速度: 128 kbit/sec
• データ分割: 端末Aから送られるデータは740バイトごとに分割され、それぞれ1つのTCPセグメントで伝送されます。
• パケット構成:
    ◦ 1つのTCPセグメントは1つのIPパケットで伝送されます。
    ◦ 1つのIPパケットは1つの衛星回線のフレームで伝送されます。
• ヘッダ長: 衛星回線のフレーム、IP、TCPのヘッダ長はすべて20バイトです。
• ACKに関する仮定: 受信側より返される送達確認（ACK）の作成時間および伝送遅延は無視できるものとします。
• 伝搬遅延: 衛星通信回線の伝搬遅延は295ミリ秒です。
• 回線品質: 回線上で誤りは発生しないものとします。
問い（計算問題）
1. フレームの大きさ:
    ◦ 端末Aから送られるフレームの大きさは何バイトになるか。
    ◦ ヒント: 衛星回線フレームのヘッダ＋IPヘッダ＋TCPヘッダ＋データ長。
2. フレームの伝送遅延:
    ◦ 端末Aから送られるフレームの伝送遅延は何秒になるか。
    ◦ ヒント: 衛星回線の回線速度から求める。
3. ストップアンドウェイトARQの最大スループット:
    ◦ ストップアンドウェイトARQ（ウィンドウサイズ1の連続ARQ）を用いる場合の最大スループットは何kb/sになるか。
    ◦ ヒント: ヘッダ以外のデータ量で計算する。
4. ウィンドウ制御による連続ARQの最大スループット（ウィンドウごとに確認応答）:
    ◦ ウィンドウごとに確認応答する場合、ウィンドウサイズ1, 5, 10, 100（単位はフレーム）に対する最大スループットは何kb/sになるか。
    ◦ ヒント: 図1を参照。
5. スライディングウィンドウ制御の最大スループット:
    ◦ スライディングウィンドウ制御で確認応答する場合、ウィンドウサイズ1, 5, 10, 100（単位はフレーム）に対する最大スループットは何kb/sになるか。
    ◦ ヒント: 図2を参照。
補足情報と提出要件
• 図1は「ウィンドウごとに確認応答」の方式を、図2は「スライディングウィンドウ」の方式を示しており、それぞれ「伝搬遅延」「1フレームの伝送遅延」「伝搬遅延」および「Window size / Line speed」の要素が示されています。
• 両図には「※ウィンドウサイズが4フレームで固定の場合」という注釈があります

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Japanese university lecture assignment repository for "情報ネットワーク" (Information Network) lesson 14. The repository contains academic work and reports.

## Project Structure

- `report.md` - Main report file written in Japanese for the Information Network course assignment

## Language and Context

- Primary language: Japanese
- Academic context: University coursework for Information Network studies
- Files contain student work including student ID (35714121) and name (福富隆大)

## Working with this Repository

This repository contains academic materials and reports. When working with files:
- Respect the academic nature of the content
- Maintain Japanese language conventions where appropriate
- Preserve student attribution and formatting in academic documents