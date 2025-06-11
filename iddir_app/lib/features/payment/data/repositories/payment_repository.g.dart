// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$paymentRepositoryHash() => r'97b951cc32e835dc7d63ef3d962a3f8fe922f9b3';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$PaymentRepository
    extends BuildlessAutoDisposeNotifier<PaymentRemoteDatasource> {
  late final Dio dio;

  PaymentRemoteDatasource build(Dio dio);
}

/// See also [PaymentRepository].
@ProviderFor(PaymentRepository)
const paymentRepositoryProvider = PaymentRepositoryFamily();

/// See also [PaymentRepository].
class PaymentRepositoryFamily extends Family<PaymentRemoteDatasource> {
  /// See also [PaymentRepository].
  const PaymentRepositoryFamily();

  /// See also [PaymentRepository].
  PaymentRepositoryProvider call(Dio dio) {
    return PaymentRepositoryProvider(dio);
  }

  @override
  PaymentRepositoryProvider getProviderOverride(
    covariant PaymentRepositoryProvider provider,
  ) {
    return call(provider.dio);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'paymentRepositoryProvider';
}

/// See also [PaymentRepository].
class PaymentRepositoryProvider
    extends
        AutoDisposeNotifierProviderImpl<
          PaymentRepository,
          PaymentRemoteDatasource
        > {
  /// See also [PaymentRepository].
  PaymentRepositoryProvider(Dio dio)
    : this._internal(
        () => PaymentRepository()..dio = dio,
        from: paymentRepositoryProvider,
        name: r'paymentRepositoryProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$paymentRepositoryHash,
        dependencies: PaymentRepositoryFamily._dependencies,
        allTransitiveDependencies:
            PaymentRepositoryFamily._allTransitiveDependencies,
        dio: dio,
      );

  PaymentRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dio,
  }) : super.internal();

  final Dio dio;

  @override
  PaymentRemoteDatasource runNotifierBuild(
    covariant PaymentRepository notifier,
  ) {
    return notifier.build(dio);
  }

  @override
  Override overrideWith(PaymentRepository Function() create) {
    return ProviderOverride(
      origin: this,
      override: PaymentRepositoryProvider._internal(
        () => create()..dio = dio,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dio: dio,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<PaymentRepository, PaymentRemoteDatasource>
  createElement() {
    return _PaymentRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PaymentRepositoryProvider && other.dio == dio;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dio.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PaymentRepositoryRef
    on AutoDisposeNotifierProviderRef<PaymentRemoteDatasource> {
  /// The parameter `dio` of this provider.
  Dio get dio;
}

class _PaymentRepositoryProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          PaymentRepository,
          PaymentRemoteDatasource
        >
    with PaymentRepositoryRef {
  _PaymentRepositoryProviderElement(super.provider);

  @override
  Dio get dio => (origin as PaymentRepositoryProvider).dio;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
