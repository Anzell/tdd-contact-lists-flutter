// Mocks generated by Mockito 5.0.16 from annotations
// in contactlistwithhive/test/domain/usecases/contact/add_contact_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:contactlistwithhive/core/errors/failures.dart' as _i5;
import 'package:contactlistwithhive/domain/entities/common/search_filter.dart'
    as _i7;
import 'package:contactlistwithhive/domain/entities/contact.dart' as _i6;
import 'package:contactlistwithhive/domain/repositories/contact_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [ContactRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockContactRepository extends _i1.Mock implements _i3.ContactRepository {
  MockContactRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>> addContact(
          {_i6.Contact? newContact}) =>
      (super.noSuchMethod(
          Invocation.method(#addContact, [], {#newContact: newContact}),
          returnValue: Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>>.value(
              _FakeEither_0<_i5.Failure, _i2.None<dynamic>>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>> removeContact(
          {String? contactId}) =>
      (super.noSuchMethod(
          Invocation.method(#removeContact, [], {#contactId: contactId}),
          returnValue: Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>>.value(
              _FakeEither_0<_i5.Failure, _i2.None<dynamic>>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>> updateContact(
          {_i6.Contact? contact}) =>
      (super.noSuchMethod(
          Invocation.method(#updateContact, [], {#contact: contact}),
          returnValue: Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>>.value(
              _FakeEither_0<_i5.Failure, _i2.None<dynamic>>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Contact>>> getAllContacts() =>
      (super.noSuchMethod(Invocation.method(#getAllContacts, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.Contact>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.Contact>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.Contact>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Contact>>> getContactsByFilter(
          {_i7.SearchFilter? filter}) =>
      (super.noSuchMethod(
          Invocation.method(#getContactsByFilter, [], {#filter: filter}),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.Contact>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.Contact>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.Contact>>>);
  @override
  String toString() => super.toString();
}
