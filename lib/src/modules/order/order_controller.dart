import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../dto/order/order_dto.dart';
import '../../models/orders/order_model.dart';
import '../../models/orders/order_status.dart';
import '../../repositories/order/order_repository.dart';
import '../../services/login/order/get_order_by_id.dart';
part 'order_controller.g.dart';

enum OrderStateStus {
  initial,
  lading,
  loaded,
  error,
  showDetailModal,
  statusChanged,
}

class OrderController = OrderControllerBase with _$OrderController;

abstract class OrderControllerBase with Store {
  final OrderRepository _orderRepository;
  final GetOrderById _getOrderById;

  @readonly
  var _status = OrderStateStus.initial;

  late final DateTime _today;

  @readonly
  OrderStatus? _statusFilter;

  @readonly
  var _orders = <OrderModel>[];

  @readonly
  String? _erroMessage;

  @readonly
  OrderDto? _orderSelected;

  OrderControllerBase(this._orderRepository, this._getOrderById) {
    final todayNow = DateTime.now();
    _today = DateTime(todayNow.year, todayNow.month, todayNow.day);
  }

  @action
  Future<void> findOrders() async {
    try {
      _status = OrderStateStus.lading;
      _orders = await _orderRepository.findAllOrders(_today, _statusFilter);
      _status = OrderStateStus.loaded;
    } catch (e, s) {
      log('Erro ao buscar pedidos do dia', error: e, stackTrace: s);
      _status = OrderStateStus.error;
      _erroMessage = 'Erro ao buscar pedidos do dia';
    }
  }

  @action
  Future<void> showDetailModel(OrderModel order) async {
    _status = OrderStateStus.lading;
    _orderSelected = await _getOrderById(order);
    _status = OrderStateStus.showDetailModal;
  }

  @action
  void changeStatusFilter(OrderStatus? status) {
    _statusFilter = status;
    findOrders();
  }

  @action
  Future<void> changeStatus(OrderStatus status) async {
    _status = OrderStateStus.lading;
    await _orderRepository.changeStatus(_orderSelected!.id, status);
    _status = OrderStateStus.statusChanged;
  }
}
